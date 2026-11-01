using Amazon.Runtime;
using Amazon.S3;
using Mint.Blog.Common.Email;
using Mint.Blog.Common.Security;
using Mint.Blog.Common.Storage;
using Mint.Blog.Model.Options;
using Mint.Blog.Repository.IRepository.Blog;
using Mint.Blog.Repository.IRepository.System;
using Mint.Blog.Repository.Persistence;
using Mint.Blog.Repository.Repositorys.Blog;
using Mint.Blog.Repository.Repositorys.System;
using Mint.Blog.Service.BackgroundJobs;
using Mint.Blog.Service.IService.Blog;
using Mint.Blog.Service.IService.System;
using Mint.Blog.Service.Services.Blog;
using Mint.Blog.Service.Services.System;

namespace Mint.Blog.WebApi.Extensions;

public static class BackendServiceCollectionExtensions {
	public static IServiceCollection AddBackend(this IServiceCollection services, IConfiguration configuration){
		services.Configure<PostgreSqlOptions>(configuration.GetSection(PostgreSqlOptions.SectionName));
		services.Configure<JwtOptions>(configuration.GetSection(JwtOptions.SectionName));
		services.Configure<RustFsOptions>(configuration.GetSection(RustFsOptions.SectionName));
		services.Configure<SmtpOptions>(configuration.GetSection(SmtpOptions.SectionName));
		services.Configure<CommentNotificationOptions>(configuration.GetSection(CommentNotificationOptions.SectionName));
		services.AddOptions<SiteOptions>()
			.Bind(configuration.GetSection(SiteOptions.SectionName))
			.Validate(options => Uri.TryCreate(options.Url, UriKind.Absolute, out var uri)
			                     && (uri.Scheme == Uri.UriSchemeHttps || uri.Scheme == Uri.UriSchemeHttp)
			                     && string.IsNullOrEmpty(uri.UserInfo)
			                     && string.IsNullOrEmpty(uri.Query)
			                     && string.IsNullOrEmpty(uri.Fragment),
				"Site:Url must be an absolute HTTP(S) frontend URL without credentials, query or fragment.")
			.Validate(options => string.IsNullOrWhiteSpace(options.FeedUrl)
			                     || (Uri.TryCreate(options.FeedUrl, UriKind.Absolute, out var uri)
			                         && (uri.Scheme == Uri.UriSchemeHttps || uri.Scheme == Uri.UriSchemeHttp)
			                         && string.IsNullOrEmpty(uri.UserInfo)
			                         && string.IsNullOrEmpty(uri.Fragment)),
				"Site:FeedUrl must be an absolute HTTP(S) feed URL without credentials or fragment.");

		services.AddSingleton<IAmazonS3>(_ => {
			var options = configuration.GetSection(RustFsOptions.SectionName).Get<RustFsOptions>() ?? new RustFsOptions();
			if (string.IsNullOrWhiteSpace(options.Endpoint))
				throw new InvalidOperationException("RustFS endpoint is not configured.");
			var serviceUrl = NormalizeRustFsServiceUrl(options.Endpoint, options.UseSsl);
			return new AmazonS3Client(new BasicAWSCredentials(options.AccessKey, options.SecretKey), new AmazonS3Config {
				ServiceURL = serviceUrl,
				ForcePathStyle = true,
				UseHttp = !serviceUrl.StartsWith("https://", StringComparison.OrdinalIgnoreCase)
			});
		});
		services.AddScoped<ISqlSugarDbContext, SqlSugarDbContext>();
		services.AddScoped<IUnitOfWork, SqlSugarUnitOfWork>();
		services.AddScoped<ITokenService, JwtTokenService>();
		services.AddScoped<IPasswordHasher, BCryptPasswordHasher>();
		services.AddScoped<IEmailSender, SmtpEmailSender>();
		services.AddScoped<IObjectStorageService, RustFsObjectStorageService>();
		services.AddScoped<IObjectStorageQueryService, RustFsObjectStorageQueryService>();
		services.AddScoped<IObjectStorageBucketService, RustFsBucketService>();

		services.AddHttpClient<IQqUserInfoService, QqUserInfoService>();
		services.AddSingleton<ISensitiveWordService, SensitiveWordService>();
		services.AddSingleton<CommentNotificationQueue>();
		services.AddSingleton<ICommentNotificationQueue>(provider => provider.GetRequiredService<CommentNotificationQueue>());
		services.AddSingleton<ArticleReadTrackingQueue>();
		services.AddSingleton<IArticleReadQueue>(provider => provider.GetRequiredService<ArticleReadTrackingQueue>());
		services.AddHostedService<CommentNotificationBackgroundService>();
		services.AddHostedService<ArticleReadTrackingBackgroundService>();
		services.AddHostedService<PvRecordInitializationBackgroundService>();
		services.AddHostedService<UserRefreshTokenCleanupBackgroundService>();

		services.AddScoped<IAdminIdentityQuery, AdminIdentityQuery>();
		services.AddScoped<IAdminIdentityRepository, AdminIdentityRepository>();
		services.AddScoped<IAdminAuditService, AdminAuditService>();
		services.AddScoped<IAdminModuleService, AdminModuleService>();
		services.AddScoped<IAdminModuleRepository, AdminModuleRepository>();
		services.AddScoped<IAdminRbacService, AdminRbacService>();
		services.AddScoped<IAdminRbacRepository, AdminRbacRepository>();
		services.AddScoped<IAuthService, AuthService>();
		services.AddScoped<IAuthRepository, AuthRepository>();
		services.AddScoped<ICommentService, CommentService>();
		services.AddScoped<ICommentRepository, CommentRepository>();
		services.AddScoped<ICommentNotificationService, CommentNotificationService>();
		services.AddScoped<IImageService, ImageService>();
		services.AddScoped<IManagedImageService, ManagedImageService>();
		services.AddScoped<IImageRepository, ImageRepository>();
		services.AddScoped<IStatisticsService, StatisticsService>();
		services.AddScoped<IStatisticsRepository, StatisticsRepository>();
		services.AddScoped<IPublicArticleService, PublicArticleService>();
		services.AddScoped<IArticleRepository, ArticleRepository>();
		services.AddScoped<IArticleService, ArticleService>();
		services.AddScoped<IArticleDraftRepository, ArticleDraftRepository>();
		services.AddScoped<IArticleDraftService, ArticleDraftService>();
		services.AddScoped<ArticleTagVersionService>();
		services.AddScoped<IArticleImageStorage, ArticleImageStorageAdapter>();
		services.AddScoped<IBlogSettingRepository, BlogSettingRepository>();
		services.AddScoped<IBlogSettingService, BlogSettingService>();
		services.AddScoped<ICategoryRepository, CategoryRepository>();
		services.AddScoped<ICategoryService, CategoryService>();
		services.AddScoped<IFriendRepository, FriendRepository>();
		services.AddScoped<IFriendService, FriendService>();
		services.AddScoped<IFriendApplicationEvents, FriendApplicationEvents>();
		services.AddScoped<IFeedMetadataReader, FeedMetadataReader>();
		services.AddScoped<ITagRepository, TagRepository>();
		services.AddScoped<ITagService, TagService>();
		services.AddScoped<IColumnRepository, ColumnRepository>();
		services.AddScoped<IColumnService, ColumnService>();
		services.AddScoped<IMessageRepository, MessageRepository>();
		services.AddScoped<IMessageService, MessageService>();
		services.AddScoped<IResourceRepository, ResourceRepository>();
		services.AddScoped<IResourceService, ResourceService>();
		services.AddScoped<IGalleryRepository, GalleryRepository>();
		services.AddScoped<IGalleryService, GalleryService>();
		return services;
	}

	private static string NormalizeRustFsServiceUrl(string endpoint, bool useSsl){
		var trimmedEndpoint = endpoint.Trim().TrimEnd('/');
		if (string.IsNullOrWhiteSpace(trimmedEndpoint)) return string.Empty;
		if (Uri.TryCreate(trimmedEndpoint, UriKind.Absolute, out var uri)) return uri.ToString().TrimEnd('/');
		var scheme = useSsl ? Uri.UriSchemeHttps : Uri.UriSchemeHttp;
		return $"{scheme}://{trimmedEndpoint}";
	}
}

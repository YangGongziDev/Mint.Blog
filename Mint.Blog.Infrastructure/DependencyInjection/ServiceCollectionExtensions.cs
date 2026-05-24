using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Minio;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.Blog.Article.Commands.CreateArticle;
using Mint.Blog.Application.Blog.Article.Commands.DeleteArticle;
using Mint.Blog.Application.Blog.Article.Commands.SetArticleTop;
using Mint.Blog.Application.Blog.Article.Commands.UpdateArticle;
using Mint.Blog.Application.Blog.Article.Queries.GetArchivePageList;
using Mint.Blog.Application.Blog.Article.Queries.GetArchiveYearList;
using Mint.Blog.Application.Blog.Article.Queries.GetArchiveYears;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleDetail;
using Mint.Blog.Application.Blog.Article.Queries.GetArticleList;
using Mint.Blog.Application.Blog.Article.Queries.GetBlogHome;
using Mint.Blog.Application.Blog.Article.Queries.SearchArticles;
using Mint.Blog.Application.Blog.Article.Drafts;
using Mint.Blog.Application.System.Auth.Login;
using Mint.Blog.Application.System.Auth.RefreshToken;
using Mint.Blog.Application.System.Auth.Logout;
using Mint.Blog.Application.Blog.Setting.Commands.UpdateBlogSettings;
using Mint.Blog.Application.Blog.Setting.Queries.GetBlogSettingsDetail;
using Mint.Blog.Application.Blog.Category.Commands.CreateCategory;
using Mint.Blog.Application.Blog.Category.Commands.DeleteCategory;
using Mint.Blog.Application.Blog.Category.Commands.MoveCategorySortFirst;
using Mint.Blog.Application.Blog.Category.Commands.MoveCategorySortLast;
using Mint.Blog.Application.Blog.Category.Commands.UpdateCategory;
using Mint.Blog.Application.Blog.Category.Commands.UpdateCategorySort;
using Mint.Blog.Application.Blog.Category.Queries.GetCategoryList;
using Mint.Blog.Application.Blog.Category.Queries.GetCategoryPageList;
using Mint.Blog.Application.Blog.Comment.Commands.DeleteComment;
using Mint.Blog.Application.Blog.Comment.Commands.ExamineComment;
using Mint.Blog.Application.Blog.Comment.Commands.PublishComment;
using Mint.Blog.Application.Blog.Comment.EventHandlers;
using Mint.Blog.Application.Blog.Comment.Notifications;
using Mint.Blog.Application.Blog.Comment.Queries.GetAdminCommentPageList;
using Mint.Blog.Application.Blog.Comment.Queries.GetCommentList;
using Mint.Blog.Application.Blog.Comment.Queries.GetQqUserInfo;
using Mint.Blog.Application.Blog.Friend.Commands.ApplyFriend;
using Mint.Blog.Application.Blog.Friend.Commands.CreateAdminFriend;
using Mint.Blog.Application.Blog.Friend.Commands.DeleteFriend;
using Mint.Blog.Application.Blog.Friend.Commands.MoveFriendSortFirst;
using Mint.Blog.Application.Blog.Friend.Commands.MoveFriendSortLast;
using Mint.Blog.Application.Blog.Friend.Commands.SetFriendStatus;
using Mint.Blog.Application.Blog.Friend.Commands.SetFriendTop;
using Mint.Blog.Application.Blog.Friend.Commands.UpdateFriend;
using Mint.Blog.Application.Blog.Friend.Commands.UpdateFriendSort;
using Mint.Blog.Application.Blog.Friend.EventHandlers;
using Mint.Blog.Application.Blog.Friend.Queries.GetAdminFriendPageList;
using Mint.Blog.Application.Blog.Friend.Queries.GetFriendDetail;
using Mint.Blog.Application.Blog.Friend.Queries.GetFriendList;
using Mint.Blog.Application.Blog.Message.Commands.PublishMessage;
using Mint.Blog.Application.Blog.Message.Queries.GetMessageList;
using Mint.Blog.Application.Blog.Statistics.Commands.TrackArticleRead;
using Mint.Blog.Application.Blog.Statistics.Queries.GetAdminDashboardPublishArticleStatistics;
using Mint.Blog.Application.Blog.Statistics.Queries.GetAdminDashboardPvStatistics;
using Mint.Blog.Application.Blog.Statistics.Queries.GetAdminDashboardStatistics;
using Mint.Blog.Application.Blog.Statistics.Queries.GetBlogStatistics;
using Mint.Blog.Application.Blog.Tag.Commands.CreateTag;
using Mint.Blog.Application.Blog.Tag.Commands.DeleteTag;
using Mint.Blog.Application.Blog.Tag.Commands.MoveTagSortFirst;
using Mint.Blog.Application.Blog.Tag.Commands.MoveTagSortLast;
using Mint.Blog.Application.Blog.Tag.Commands.UpdateTag;
using Mint.Blog.Application.Blog.Tag.Commands.UpdateTagSort;
using Mint.Blog.Application.Blog.Tag.Queries.GetTagList;
using Mint.Blog.Application.Blog.Tag.Queries.GetTagPageList;
using Mint.Blog.Application.Blog.Upload.Commands.DeleteFile;
using Mint.Blog.Application.Blog.Upload.Commands.DeleteImage;
using Mint.Blog.Application.Blog.Upload.Commands.DeleteImages;
using Mint.Blog.Application.Blog.Upload.Commands.MoveImage;
using Mint.Blog.Application.Blog.Upload.Commands.MoveImages;
using Mint.Blog.Application.Blog.Upload.Commands.RenameImage;
using Mint.Blog.Application.Blog.Upload.Commands.UploadFile;
using Mint.Blog.Application.Blog.Upload.Commands.UploadImage;
using Mint.Blog.Application.Blog.Upload.Images;
using Mint.Blog.Application.System.Menu.Queries.GetAllPages;
using Mint.Blog.Application.System.Menu.Queries.GetMenuList;
using Mint.Blog.Application.System.Menu.Queries.GetMenuTree;
using Mint.Blog.Application.System.Role.Queries.GetAllRoles;
using Mint.Blog.Application.System.Role.Queries.GetRoleList;
using Mint.Blog.Application.System.User.Commands.DeleteUser;
using Mint.Blog.Application.System.User.Commands.UpdateSystemUserPassword;
using Mint.Blog.Application.System.User.Commands.UpdateUser;
using Mint.Blog.Application.System.User.Queries.GetSystemUserInfo;
using Mint.Blog.Application.System.User.Queries.GetUserList;
using Mint.Blog.Application.Blog.Column.Commands.CreateColumn;
using Mint.Blog.Application.Blog.Column.Commands.DeleteColumn;
using Mint.Blog.Application.Blog.Column.Commands.SetColumnPublish;
using Mint.Blog.Application.Blog.Column.Commands.SetColumnTop;
using Mint.Blog.Application.Blog.Column.Commands.UpdateColumn;
using Mint.Blog.Application.Blog.Column.Commands.UpdateColumnCatalog;
using Mint.Blog.Application.Blog.Column.Commands.UpdateColumnSort;
using Mint.Blog.Application.Blog.Column.Queries.GetAdminColumnCatalog;
using Mint.Blog.Application.Blog.Column.Queries.GetAdminColumnPageList;
using Mint.Blog.Application.Blog.Column.Queries.GetBlogColumnArticlePreNext;
using Mint.Blog.Application.Blog.Column.Queries.GetBlogColumnCatalog;
using Mint.Blog.Application.Blog.Column.Queries.GetBlogColumnList;
using Mint.Blog.Domain.Blog.Article.Repositories;
using Mint.Blog.Domain.Blog.Setting.Repositories;
using Mint.Blog.Domain.Blog.Category.Repositories;
using Mint.Blog.Domain.Blog.Comment.Repositories;
using Mint.Blog.Domain.Blog.Friend.Repositories;
using Mint.Blog.Domain.Blog.Message.Repositories;
using Mint.Blog.Domain.Blog.Tag.Repositories;
using Mint.Blog.Domain.System.User.Repositories;
using Mint.Blog.Domain.Blog.Column.Repositories;
using Mint.Blog.Infrastructure.System.Auth;
using Mint.Blog.Infrastructure.Blog.Statistics.BackgroundJobs;
using Mint.Blog.Infrastructure.Blog.Comment.BackgroundJobs;
using Mint.Blog.Infrastructure.Blog.Comment.QqUserInfo;
using Mint.Blog.Infrastructure.Blog.Comment.SensitiveWords;
using Mint.Blog.Infrastructure.Blog.Comment.Notifications;
using Mint.Blog.Infrastructure.Common.DomainEvents;
using Mint.Blog.Infrastructure.Options;
using Mint.Blog.Infrastructure.Blog.Persistence;
using Mint.Blog.Infrastructure.Blog.Article.Repositories;
using Mint.Blog.Infrastructure.Blog.Article.Drafts;
using Mint.Blog.Infrastructure.Blog.Category.Repositories;
using Mint.Blog.Infrastructure.Blog.Tag.Repositories;
using Mint.Blog.Infrastructure.Blog.Comment.Repositories;
using Mint.Blog.Infrastructure.Blog.Friend.Repositories;
using Mint.Blog.Infrastructure.Blog.Message.Repositories;
using Mint.Blog.Infrastructure.Blog.Setting.Repositories;
using Mint.Blog.Infrastructure.Blog.Column.Repositories;
using Mint.Blog.Infrastructure.Blog.Statistics.Repositories;
using Mint.Blog.Infrastructure.Blog.Persistence.SqlSugar;
using Mint.Blog.Infrastructure.Blog.Upload;
using Mint.Blog.Infrastructure.System.Menu;
using Mint.Blog.Infrastructure.System.Role;
using Mint.Blog.Infrastructure.System.User.Persistence.Repositories;

namespace Mint.Blog.Infrastructure.DependencyInjection;

public static class ServiceCollectionExtensions {
	public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration){
		services.Configure<PostgreSqlOptions>(configuration.GetSection(PostgreSqlOptions.SectionName));
		services.Configure<JwtOptions>(configuration.GetSection(JwtOptions.SectionName));
		services.Configure<MinioOptions>(configuration.GetSection(MinioOptions.SectionName));
		services.Configure<SmtpOptions>(configuration.GetSection(SmtpOptions.SectionName));
		services.Configure<CommentNotificationOptions>(
			configuration.GetSection(CommentNotificationOptions.SectionName));

		services.AddHttpClient<QqUserInfoQueryService>();
		services.AddSingleton<ISensitiveWordService, SensitiveWordService>();
		services.AddSingleton<CommentNotificationQueue>();
		services.AddSingleton<ICommentNotificationQueue>(provider =>
			provider.GetRequiredService<CommentNotificationQueue>());
		services.AddSingleton<ArticleReadTrackingQueue>();
		services.AddSingleton<IArticleReadTrackingQueue>(provider =>
			provider.GetRequiredService<ArticleReadTrackingQueue>());
		services.AddHostedService<CommentNotificationBackgroundService>();
		services.AddHostedService<ArticleReadTrackingBackgroundService>();
		services.AddHostedService<PvRecordInitializationBackgroundService>();
		services.AddSingleton<IMinioClient>(_ => {
			var minioOptions = configuration.GetSection(MinioOptions.SectionName).Get<MinioOptions>() ?? new MinioOptions();
			var endpoint = NormalizeMinioEndpoint(minioOptions.Endpoint, out var endpointUsesSsl);
			if (string.IsNullOrWhiteSpace(endpoint))
				throw new InvalidOperationException("Minio endpoint is not configured.");

			var builder = new MinioClient()
				.WithEndpoint(endpoint)
				.WithCredentials(minioOptions.AccessKey, minioOptions.SecretKey);

			if (minioOptions.UseSsl || endpointUsesSsl) builder = builder.WithSSL();

			return builder.Build();
		});
		services.AddScoped<ISqlSugarDbContext, SqlSugarDbContext>();
		services.AddScoped<IUnitOfWork, SqlSugarUnitOfWork>();
		services.AddScoped<IDomainEventDispatcher, ServiceProviderDomainEventDispatcher>();
		services.AddScoped<ITokenService, JwtTokenService>();
		services.AddScoped<IPasswordHasher, BCryptPasswordHasher>();
		services.AddScoped<IAdminCredentialValidator, ConfiguredAdminCredentialValidator>();
		services.AddScoped<IEmailSender, SmtpEmailSender>();
		services.AddScoped<ICommentNotificationService, CommentNotificationService>();
		services.AddScoped<IObjectStorageService, MinioObjectStorageService>();
		services.AddScoped<IImageUsageService, ImageUsageService>();
		services.AddScoped<IImageReferenceUpdateService, ImageReferenceUpdateService>();
		services.AddScoped<IObjectStorageBucketService, MinioBucketService>();
		services.AddScoped<IManagedImageQueryService, ManagedImageQueryService>();
		services.AddScoped<StatisticsCommandRepository>();

		services.AddScoped<IArticleRepository, ArticleRepository>();
		services.AddScoped<IArticleDraftService, ArticleDraftService>();
		services.AddScoped<IBlogSettingRepository, BlogSettingRepository>();
		services.AddScoped<ICategoryRepository, CategoryRepository>();
		services.AddScoped<ICommentRepository, CommentRepository>();
		services.AddScoped<IFriendRepository, FriendRepository>();
		services.AddScoped<ITagRepository, TagRepository>();
		services.AddScoped<IUserRepository, UserRepository>();
		services.AddScoped<IUserRefreshTokenRepository, UserRefreshTokenRepository>();
		services.AddScoped<IColumnRepository, ColumnRepository>();
		services.AddScoped<IMessageRepository, MessageRepository>();

		services.AddScoped<IGetArticleDetailQueryService, ArticleRepository>();
		services.AddScoped<IGetArticleListQueryService, ArticleRepository>();
		services.AddScoped<IGetBlogHomeQueryService, ArticleRepository>();
		services.AddScoped<ISearchArticlesQueryService, ArticleRepository>();
		services.AddScoped<IGetArchivePageListQueryService, ArticleRepository>();
		services.AddScoped<IGetArchiveYearListQueryService, ArticleRepository>();
		services.AddScoped<IGetArchiveYearsQueryService, ArticleRepository>();
		services.AddScoped<IGetBlogSettingsDetailQueryService, BlogSettingRepository>();
		services.AddScoped<IGetCategoryListQueryService, CategoryRepository>();
		services.AddScoped<IGetCategoryPageListQueryService, CategoryRepository>();
		services.AddScoped<IGetCommentListQueryService, CommentRepository>();
		services.AddScoped<IGetAdminCommentPageListQueryService, CommentRepository>();
		services.AddScoped<IGetQqUserInfoQueryService, QqUserInfoQueryService>();
		services.AddScoped<IGetFriendListQueryService, FriendRepository>();
		services.AddScoped<IGetFriendDetailQueryService, FriendRepository>();
		services.AddScoped<IGetAdminFriendPageListQueryService, FriendRepository>();
		services.AddScoped<IGetTagListQueryService, TagRepository>();
		services.AddScoped<IGetTagPageListQueryService, TagRepository>();
		services.AddScoped<IGetSystemUserInfoQueryService, UserRepository>();
		services.AddScoped<IGetUserListQueryService, UserRepository>();
		services.AddScoped<IGetRoleListQueryService, RoleQueryService>();
		services.AddScoped<IGetAllRolesQueryService, RoleQueryService>();
		services.AddScoped<IGetMenuListQueryService, MenuQueryService>();
		services.AddScoped<IGetAllPagesQueryService, MenuQueryService>();
		services.AddScoped<IGetMenuTreeQueryService, MenuQueryService>();
		services.AddScoped<IGetBlogStatisticsQueryService, StatisticsQueryRepository>();
		services.AddScoped<IGetAdminDashboardStatisticsQueryService, StatisticsQueryRepository>();
		services.AddScoped<IGetAdminDashboardPvStatisticsQueryService, StatisticsQueryRepository>();
		services.AddScoped<IGetAdminDashboardPublishArticleStatisticsQueryService, StatisticsQueryRepository>();
		services.AddScoped<IGetAdminColumnPageListQueryService, ColumnRepository>();
		services.AddScoped<IGetAdminColumnCatalogQueryService, ColumnRepository>();
		services.AddScoped<IGetBlogColumnListQueryService, ColumnRepository>();
		services.AddScoped<IGetBlogColumnCatalogQueryService, ColumnRepository>();
		services.AddScoped<IGetBlogColumnArticlePreNextQueryService, ColumnRepository>();
		services.AddScoped<IGetMessageListQueryService, MessageRepository>();

		services.AddScoped<LoginCommandHandler>();
		services.AddScoped<RefreshTokenCommandHandler>();
		services.AddScoped<LogoutCommandHandler>();
		services.AddScoped<UpdateBlogSettingsCommandHandler>();
		services.AddScoped<PublishCommentCommandHandler>();
		services.AddScoped<DeleteCommentCommandHandler>();
		services.AddScoped<ExamineCommentCommandHandler>();
		services.AddScoped<IDomainEventHandler<Domain.Blog.Comment.Events.CommentPublishedDomainEvent>,
			CommentPublishedDomainEventHandler>();
		services.AddScoped<IDomainEventHandler<Domain.Blog.Comment.Events.CommentExaminedDomainEvent>,
			CommentExaminedDomainEventHandler>();
		services.AddScoped<IDomainEventHandler<Domain.Blog.Friend.Events.FriendAppliedDomainEvent>,
			FriendAppliedDomainEventHandler>();
		services.AddScoped<CreateArticleCommandHandler>();
		services.AddScoped<UpdateArticleCommandHandler>();
		services.AddScoped<DeleteArticleCommandHandler>();
		services.AddScoped<SetArticleTopCommandHandler>();
		services.AddScoped<CreateCategoryCommandHandler>();
		services.AddScoped<UpdateCategoryCommandHandler>();
		services.AddScoped<DeleteCategoryCommandHandler>();
		services.AddScoped<UpdateCategorySortCommandHandler>();
		services.AddScoped<MoveCategorySortFirstCommandHandler>();
		services.AddScoped<MoveCategorySortLastCommandHandler>();
		services.AddScoped<CreateTagCommandHandler>();
		services.AddScoped<UpdateTagCommandHandler>();
		services.AddScoped<DeleteTagCommandHandler>();
		services.AddScoped<UpdateTagSortCommandHandler>();
		services.AddScoped<MoveTagSortFirstCommandHandler>();
		services.AddScoped<MoveTagSortLastCommandHandler>();
		services.AddScoped<ApplyFriendCommandHandler>();
		services.AddScoped<CreateAdminFriendCommandHandler>();
		services.AddScoped<UpdateFriendCommandHandler>();
		services.AddScoped<DeleteFriendCommandHandler>();
		services.AddScoped<SetFriendTopCommandHandler>();
		services.AddScoped<SetFriendStatusCommandHandler>();
		services.AddScoped<UpdateFriendSortCommandHandler>();
		services.AddScoped<MoveFriendSortFirstCommandHandler>();
		services.AddScoped<MoveFriendSortLastCommandHandler>();
		services.AddScoped<UpdateSystemUserPasswordCommandHandler>();
		services.AddScoped<UpdateUserCommandHandler>();
		services.AddScoped<DeleteUserCommandHandler>();
		services.AddScoped<UploadImageCommandHandler>();
		services.AddScoped<DeleteImageCommandHandler>();
		services.AddScoped<DeleteImagesCommandHandler>();
		services.AddScoped<RenameImageCommandHandler>();
		services.AddScoped<MoveImageCommandHandler>();
		services.AddScoped<MoveImagesCommandHandler>();
		services.AddScoped<UploadFileCommandHandler>();
		services.AddScoped<DeleteFileCommandHandler>();
		services.AddScoped<CreateColumnCommandHandler>();
		services.AddScoped<UpdateColumnCommandHandler>();
		services.AddScoped<DeleteColumnCommandHandler>();
		services.AddScoped<SetColumnPublishCommandHandler>();
		services.AddScoped<SetColumnTopCommandHandler>();
		services.AddScoped<UpdateColumnSortCommandHandler>();
		services.AddScoped<UpdateColumnCatalogCommandHandler>();
		services.AddScoped<PublishMessageCommandHandler>();
		services.AddScoped<UpdateUserRoleCommandHandler>();

		return services;
	}

	private static string NormalizeMinioEndpoint(string endpoint, out bool usesSsl){
		usesSsl = false;
		var trimmedEndpoint = endpoint.Trim();
		if (string.IsNullOrWhiteSpace(trimmedEndpoint)) return string.Empty;

		if (Uri.TryCreate(trimmedEndpoint, UriKind.Absolute, out var uri)) {
			usesSsl = string.Equals(uri.Scheme, Uri.UriSchemeHttps, StringComparison.OrdinalIgnoreCase);
			return uri.IsDefaultPort ? uri.Host : $"{uri.Host}:{uri.Port}";
		}

		return trimmedEndpoint;
	}
}

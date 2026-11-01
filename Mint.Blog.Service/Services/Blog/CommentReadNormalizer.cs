using System.Net.Mail;
using Mint.Blog.Model.Entitys.Blog.Comment;

namespace Mint.Blog.Service.Services.Blog;

internal static class CommentReadNormalizer {
    public static CommentDataModel? Normalize(CommentDataModel? comment) {
        if (comment is null) return null;
        comment.Content = Content(comment.Content);
        comment.Nickname = Nickname(comment.Nickname);
        comment.Mail = Mail(comment.Mail);
        comment.Website = Website(comment.Website);
        comment.IsDeleted = comment.IsDeleted != 0 ? (short)1 : (short)0;
        return comment;
    }

    public static void NormalizeAll(IReadOnlyCollection<CommentDataModel> comments) {
        foreach (var comment in comments) Normalize(comment);
    }

    private static string Content(string value) {
        if (string.IsNullOrWhiteSpace(value)) throw new ArgumentException("Comment content is required.", nameof(value));
        var normalized = value.Trim();
        if (normalized.Length > 120) throw new ArgumentException("Comment content length must be less than or equal to 120.", nameof(value));
        return normalized;
    }

    private static string Nickname(string value) {
        if (string.IsNullOrWhiteSpace(value)) throw new ArgumentException("Nickname is required.", nameof(value));
        var normalized = value.Trim();
        if (normalized.Length > 50) throw new ArgumentException("Nickname length must be less than or equal to 50.", nameof(value));
        return normalized;
    }

    private static string Mail(string value) {
        if (string.IsNullOrWhiteSpace(value)) throw new ArgumentException("Email address is required.", nameof(value));
        var normalized = value.Trim();
        if (!MailAddress.TryCreate(normalized, out _)) throw new ArgumentException("Email address format is invalid.", nameof(value));
        return normalized;
    }

    private static string Website(string? value) {
        if (string.IsNullOrWhiteSpace(value)) return string.Empty;
        var normalized = value.Trim();
        if (!Uri.TryCreate(normalized, UriKind.Absolute, out _)) throw new ArgumentException("Website url format is invalid.", nameof(value));
        return normalized;
    }
}

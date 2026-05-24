using Mint.Blog.Application.Abstractions;

namespace Mint.Blog.Application.Blog.Upload.Commands.MoveImages;

public sealed record MoveImagesPrecheckResult(IReadOnlyCollection<ObjectMoveConflict> Conflicts);

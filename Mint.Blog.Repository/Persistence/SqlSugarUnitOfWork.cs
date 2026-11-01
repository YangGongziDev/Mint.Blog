namespace Mint.Blog.Repository.Persistence;

public sealed class SqlSugarUnitOfWork(ISqlSugarDbContext dbContext) : IUnitOfWork {
    public Task BeginTransactionAsync(CancellationToken cancellationToken = default){
        dbContext.Client.Ado.BeginTran();
        return Task.CompletedTask;
    }
    public Task CommitAsync(CancellationToken cancellationToken = default){
        dbContext.Client.Ado.CommitTran();
        return Task.CompletedTask;
    }
    public Task RollbackAsync(CancellationToken cancellationToken = default){
        dbContext.Client.Ado.RollbackTran();
        return Task.CompletedTask;
    }
}

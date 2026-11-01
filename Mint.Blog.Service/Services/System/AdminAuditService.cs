using System.Text.Json.Nodes;
using Mint.Blog.Common.Exceptions;
using Mint.Blog.Repository.IRepository.System;
using Mint.Blog.Service.IService.System;

namespace Mint.Blog.Service.Services.System;

public sealed class AdminAuditService(IAdminModuleRepository repository) : IAdminAuditService {
    public async Task RecordLogAsync(string resource, JsonObject entry) {
        if (resource is not ("loginLog" or "operationLog"))
            throw new BusinessException("VALIDATION_ERROR", "无效日志类型");
        await repository.AppendLogAsync(resource, entry.ToJsonString());
    }
}

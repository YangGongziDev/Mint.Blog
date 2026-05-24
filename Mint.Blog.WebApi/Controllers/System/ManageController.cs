using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Mint.Blog.Application.Abstractions;
using Mint.Blog.Application.System.Dtos;
using Mint.Blog.Application.System.Menu.Queries.GetAllPages;
using Mint.Blog.Application.System.Menu.Queries.GetMenuList;
using Mint.Blog.Application.System.Menu.Queries.GetMenuTree;
using Mint.Blog.Application.System.User.Queries.GetUserList;
using Mint.Blog.Application.System.Role.Commands.UpdateUserRole;
using Mint.Blog.Application.System.Role.Queries.GetAllRoles;
using Mint.Blog.Application.System.Role.Queries.GetRoleList;
using Mint.Blog.Infrastructure.System.Role;
using SystemMenuDto = Mint.Blog.Application.System.Menu.Dtos.MenuDto;
using SystemMenuTreeDto = Mint.Blog.Application.System.Menu.Dtos.MenuTreeDto;
using SystemRoleDto = Mint.Blog.Application.System.Role.Dtos.RoleDto;

namespace Mint.Blog.WebApi.Controllers.System;

/// <summary>
///     系统管理接口（角色、用户、菜单）
/// </summary>
[ApiController]
[Authorize]
[Route("api/system")]
public sealed class ManageController(
    IGetRoleListQueryService getRoleListQueryService,
    IGetAllRolesQueryService getAllRolesQueryService,
    IGetMenuListQueryService getMenuListQueryService,
    IGetAllPagesQueryService getAllPagesQueryService,
    IGetMenuTreeQueryService getMenuTreeQueryService,
    IGetUserListQueryService getUserListQueryService,
    UpdateUserRoleCommandHandler updateUserRoleCommandHandler) : ControllerBase
{
    /// <summary>
    ///     获取角色列表
    /// </summary>
    [HttpGet("getRoleList")]
    [ProducesResponseType(typeof(ApiResponse<PaginatedListDto<SystemRoleDto>>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ApiResponse<PaginatedListDto<SystemRoleDto>>>> GetRoleList(
        [FromQuery] string? userName,
        [FromQuery] string? role,
        [FromQuery] int current = 1,
        [FromQuery] int size = 10,
        CancellationToken cancellationToken = default)
    {
        var result = await getRoleListQueryService.GetAsync(
            new GetRoleListQuery(userName, role, current, size),
            cancellationToken);

        return Ok(ApiResponse<PaginatedListDto<SystemRoleDto>>.Ok(result));
    }

    [HttpPut("userRole/{id:long}")]
    [Authorize(Roles = "ROLE_ADMIN,ROLE_SUPER")]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ApiResponse<object>>> UpdateUserRole(
        long id,
        [FromBody] UpdateUserRoleCommand command,
        CancellationToken cancellationToken = default)
    {
        await updateUserRoleCommandHandler.HandleAsync(command with { Id = id }, cancellationToken);
        return Ok(ApiResponse<object>.Ok(new { id }));
    }

    /// <summary>
    ///     获取全部启用的角色
    /// </summary>
    [HttpGet("getAllRole")]
    [ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<SystemRoleDto>>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ApiResponse<IReadOnlyCollection<SystemRoleDto>>>> GetAllRoles(
        CancellationToken cancellationToken = default)
    {
        var roles = await getAllRolesQueryService.GetAsync(cancellationToken);
        return Ok(ApiResponse<IReadOnlyCollection<SystemRoleDto>>.Ok(roles));
    }

    /// <summary>
    ///     获取用户列表
    /// </summary>
    [HttpGet("getUserList")]
    [ProducesResponseType(typeof(ApiResponse<PaginatedListDto<UserDto>>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ApiResponse<PaginatedListDto<UserDto>>>> GetUserList(
        [FromQuery] string? userName,
        [FromQuery] string? displayName,
        [FromQuery] int? isDeleted,
        [FromQuery] int current = 1,
        [FromQuery] int size = 10,
        CancellationToken cancellationToken = default)
    {
        var result = await getUserListQueryService.GetAsync(
            new GetUserListQuery(userName, displayName, isDeleted, current, size),
            cancellationToken);

        return Ok(ApiResponse<PaginatedListDto<UserDto>>.Ok(result));
    }

    /// <summary>
    ///     获取菜单列表
    /// </summary>
    [HttpGet("getMenuList/v2")]
    [ProducesResponseType(typeof(ApiResponse<PaginatedListDto<SystemMenuDto>>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ApiResponse<PaginatedListDto<SystemMenuDto>>>> GetMenuListV2(
        CancellationToken cancellationToken = default)
    {
        var result = await getMenuListQueryService.GetAsync(new GetMenuListQuery(), cancellationToken);
        return Ok(ApiResponse<PaginatedListDto<SystemMenuDto>>.Ok(result));
    }

    /// <summary>
    ///     获取全部页面路由名称
    /// </summary>
    [HttpGet("getAllPage")]
    [ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<string>>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ApiResponse<IReadOnlyCollection<string>>>> GetAllPages(
        CancellationToken cancellationToken = default)
    {
        var pages = await getAllPagesQueryService.GetAsync(cancellationToken);
        return Ok(ApiResponse<IReadOnlyCollection<string>>.Ok(pages));
    }

    /// <summary>
    ///     获取菜单树
    /// </summary>
    [HttpGet("getMenuTree")]
    [ProducesResponseType(typeof(ApiResponse<IReadOnlyCollection<SystemMenuTreeDto>>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status401Unauthorized)]
    public async Task<ActionResult<ApiResponse<IReadOnlyCollection<SystemMenuTreeDto>>>> GetMenuTree(
        CancellationToken cancellationToken = default)
    {
        var menuTree = await getMenuTreeQueryService.GetAsync(cancellationToken);
        return Ok(ApiResponse<IReadOnlyCollection<SystemMenuTreeDto>>.Ok(menuTree));
    }
}

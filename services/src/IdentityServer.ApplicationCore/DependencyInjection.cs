using System.Reflection;
using FluentValidation.AspNetCore;
using IdentityServer.ApplicationCore.MapperProfiles;
using Microsoft.Extensions.DependencyInjection;

namespace IdentityServer.ApplicationCore;

public static class DependencyInjection
{
    public static IServiceCollection AddApplicationCore(this IServiceCollection services)
    {
        services.AddAutoMapper(typeof(MapperProfile));

        services.AddFluentValidationAutoValidation();
        return services;
    }
}
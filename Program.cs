using System.Text;
using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using sushi_server.Helper;
using sushi_server.Interfaces;
using sushi_server.Mapper;
using sushi_server.Models;
using sushi_server.Services;
using System.Runtime.InteropServices;
var builder = WebApplication.CreateBuilder(args);


// Determine if the environment is macOS or Windows
string connectionString = RuntimeInformation.IsOSPlatform(OSPlatform.OSX)
    ? builder.Configuration.GetConnectionString("MacConnection")  // Use MacConnection for macOS
    : builder.Configuration.GetConnectionString("DefaultConnection");  // Use DefaultConnection for Windows

// Register the DbContext with the appropriate connection string
builder.Services.AddDbContext<SushiDbContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddControllersWithViews();


Console.WriteLine($"Environment: {builder.Environment.EnvironmentName}");
// Add other services to the container
builder.Services.AddControllers();
builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles;
        options.JsonSerializerOptions.MaxDepth = 64; // Increase the maximum depth if needed
    });
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder =>
    {
        builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
    });
});

// Configure Swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "Sushi Restaurant API",
        Version = "v1",
        Description = "API for Sushi Restaurant Management System"
    });

    // Adding Authentication for Swagger
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        In = ParameterLocation.Header,
        Description = "Please enter a valid token",
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        BearerFormat = "JWT",
        Scheme = "Bearer"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            new string[] { }
        }
    });
});

// Add AutoMapper, Identity, JWT, etc. (Rest of your services)
builder.Services.AddAutoMapper(typeof(MappingProfile));
// Configure JWT Authentication
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = builder.Configuration["JwtSettings:Issuer"],
        ValidAudience = builder.Configuration["JwtSettings:Audience"],
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["JwtSettings:SigningKey"]))
    };
});


builder.Services.AddScoped<ITokenService, TokenService>();
builder.Services.AddScoped<CustomAuthorize>();


var app = builder.Build();



// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment() || app.Environment.IsProduction())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Sushi Restaurant API V1");
        if (app.Environment.IsProduction())
        {
            c.RoutePrefix = string.Empty;
        }
        else
        {
            c.RoutePrefix = "swagger";
        }
    });
}

app.UseHttpsRedirection();
app.UseCors("AllowAll"); // Apply the CORS policy
app.UseAuthentication();
app.UseAuthorization();
app.UseMiddleware<RequestTimingMiddleware>();

app.MapControllers();

app.Run();

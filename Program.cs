using System.Runtime.InteropServices;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using sushi_server.Data;
using sushi_server.Interfaces;
using sushi_server.Mapper;
using sushi_server.Models;
using sushi_server.Services;

var builder = WebApplication.CreateBuilder(args);


// Add controller
builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// adding authentication to swagger
builder.Services.AddSwaggerGen(option =>
{
    option.SwaggerDoc("v1", new OpenApiInfo { Title = "Demo API", Version = "v1" });
    option.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        In = ParameterLocation.Header,
        Description = "Please enter a valid token",
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        BearerFormat = "JWT",
        Scheme = "Bearer"
    });
    option.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type=ReferenceType.SecurityScheme,
                    Id="Bearer"
                }
            },
            new string[]{}
        }
    });
});

// Configure DBcontext 
builder.Services.AddDbContext<ApplicationDbContext>(options => {
    string connectionString;

    // Kiểm tra hệ điều hành
    if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
    {
        // Sử dụng chuỗi kết nối dành cho Windows
        connectionString = builder.Configuration.GetConnectionString("WindowsConnection");
    }
    else
    {
        // Sử dụng chuỗi kết nối dành cho Mac
        connectionString = builder.Configuration.GetConnectionString("MacConnection");
    }

    options.UseSqlServer(connectionString);
});
builder.Services.AddIdentity<AppUser, IdentityRole>(options =>
{
    options.Password.RequiredLength = 8; // Độ dài tối thiểu của mật khẩu
    options.Password.RequireNonAlphanumeric = false; // Không yêu cầu ký tự đặc biệt
    options.Password.RequireUppercase = false; // Không yêu cầu ký tự viết hoa
    options.Password.RequireLowercase = false; // Không yêu cầu ký tự viết thường
    options.Password.RequireDigit = false; // Không yêu cầu ký tự số
}).AddEntityFrameworkStores<ApplicationDbContext>();

// Configure JWT
builder.Services.AddAuthentication(options =>{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(options => {
    options.TokenValidationParameters = new TokenValidationParameters{
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = builder.Configuration["JwtSettings:Issuer"],
        ValidAudience = builder.Configuration["JwtSettings:Audience"],
        IssuerSigningKey = new SymmetricSecurityKey 
        (
            System.Text.Encoding.UTF8.GetBytes(builder.Configuration["JwtSettings:SigningKey"])
        )
    };
});

builder.Services.AddAutoMapper(typeof(MappingProfile));
builder.Services.AddScoped<ITokenService, TokenService>();


builder.Services.AddControllers().AddNewtonsoftJson(options => {
    options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore;
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
app.Run();


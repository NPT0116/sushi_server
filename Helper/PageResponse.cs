using System;
using sushi_server.Dto.Dish;

namespace sushi_server.Helper;

 public class PagedResponse<T> : Response<T>
    {
    private List<GetAllDishDto> dishDtoList;

    public int PageNumber { get; set; }
        public int PageSize { get; set; }
        public Uri FirstPage { get; set; }
        public Uri LastPage { get; set; }
        public int TotalPages { get; set; }
        public int TotalRecords { get; set; }
        public Uri NextPage { get; set; }
        public Uri PreviousPage { get; set; }

        public PagedResponse(T data, int pageNumber, int pageSize, string? message, string[]? errors, bool? succeeded)
        {
            Data = data;
            PageNumber = pageNumber;
            PageSize = pageSize;
            Message = message ?? string.Empty;
            Errors = errors ?? [];
            Succeeded = succeeded ?? true;
        }

}

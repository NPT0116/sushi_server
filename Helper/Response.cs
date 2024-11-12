using System;

namespace sushi_server.Helper;

   public class Response<T>
    {
        public T Data { get; set; }
        public bool Succeeded { get; set; }
        public string[] Errors { get; set; }
        public string Message { get; set; }
        public Response() { }
        public Response(T data, string message = "", string[] errors = null, bool succeeded = true)
        {
            Succeeded = succeeded;
            Message = message ?? string.Empty;
            Errors = errors ?? new string[0];
            Data = data;
        }
    }
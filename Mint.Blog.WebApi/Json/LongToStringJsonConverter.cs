using System.Globalization;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace Mint.Blog.WebApi.Json;

public sealed class LongToStringJsonConverter : JsonConverter<long> {
    public override long Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) => reader.TokenType switch {
        JsonTokenType.String when long.TryParse(reader.GetString(), NumberStyles.AllowLeadingSign, CultureInfo.InvariantCulture, out var value) => value,
        JsonTokenType.Number => reader.GetInt64(),
        _ => throw new JsonException("Invalid long value.")
    };
    public override void Write(Utf8JsonWriter writer, long value, JsonSerializerOptions options) =>
        writer.WriteStringValue(value.ToString(CultureInfo.InvariantCulture));
}

public sealed class NullableLongToStringJsonConverter : JsonConverter<long?> {
    public override long? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) => reader.TokenType switch {
        JsonTokenType.Null => null,
        JsonTokenType.String when long.TryParse(reader.GetString(), NumberStyles.AllowLeadingSign, CultureInfo.InvariantCulture, out var value) => value,
        JsonTokenType.Number => reader.GetInt64(),
        _ => throw new JsonException("Invalid nullable long value; use explicit null for an empty selection.")
    };
    public override void Write(Utf8JsonWriter writer, long? value, JsonSerializerOptions options) {
        if (value.HasValue) writer.WriteStringValue(value.Value.ToString(CultureInfo.InvariantCulture));
        else writer.WriteNullValue();
    }
}

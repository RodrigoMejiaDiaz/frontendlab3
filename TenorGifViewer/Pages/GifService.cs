using System;
using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;
using System.Collections.Generic;

public interface IGifService
{
    Task<List<GifModel>> GetGifsAsync(string searchQuery);
}

public class GifService : IGifService
{
    private readonly HttpClient _httpClient;

    public GifService(HttpClient httpClient)
    {
        _httpClient = httpClient ?? throw new ArgumentNullException(nameof(httpClient));
    }

    public async Task<List<GifModel>> GetGifsAsync(string searchQuery)
    {
        var resposne = await _httpClient.GetAsync($"http://ip172-18-0-17-ck46qd8gftqg00bsbseg-5200.direct.labs.play-with-docker.com/{searchQuery}");
        resposne.EnsureSuccessStatusCode();

        return await resposne.Content.ReadFromJsonAsync<List<GifModel>>();
    }
}

public class GifModel
{
    public string Id { get; set; }
    public string WebmPreviewUrl { get; set; }
}

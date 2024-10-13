using be.models;
using be.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace be.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NewsController : ControllerBase
    {
        private IRepository<New> _newsRepository;

        public NewsController(IRepository<New> newsRepository)
        {
            _newsRepository = newsRepository;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var news = await _newsRepository.GetAll();
                return Ok(new { news, message = "Retrieve successfully" });
            }
            catch(Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while retrieving news" });
            }
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            try
            {
                var news = await _newsRepository.GetById(id);
                if (news == null)
                {
                    return NotFound(new { message = "News not found" });
                }
                return Ok(news);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while retrieving news" });
            }
        }

        [HttpPost]
        public async Task<IActionResult> Post(New news)
        {
            try
            {
                var newNews = new New
                {
                    title = news.title,
                    source = news.source,
                    content = news.content,
                    date = news.date,
                    image = news.image,
                    email = news.email,
                    Created_At = DateTime.Now,
                    Updated_At = DateTime.Now,
                    Deleted = 0
                };
                await _newsRepository.Add(newNews);
                
                return Ok(new { newNews, message = "News created successfully" });
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while creating news" });
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, New news)
        {
            try
            {
                var newsToUpdate = await _newsRepository.GetById(id);
                if (newsToUpdate == null)
                {
                    return NotFound(new { message = "News not found" });
                }
                newsToUpdate.title = news.title;
                newsToUpdate.source = news.source;
                newsToUpdate.date = news.date;
                newsToUpdate.image = news.image;
                newsToUpdate.email = news.email;
                newsToUpdate.Updated_At = DateTime.Now;
                await _newsRepository.Update(newsToUpdate);
                return Ok(new { newsToUpdate, message = "News updated successfully" });
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while updating news" });
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                var newsToDelete = await _newsRepository.GetById(id);
                if (newsToDelete == null)
                {
                    return NotFound(new { message = "News not found" });
                }
                await _newsRepository.Delete(newsToDelete);
                return Ok(new { message = "News deleted successfully" });
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while deleting news" });
            }
        }

    }
}

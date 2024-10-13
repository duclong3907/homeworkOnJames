namespace be.Repository
{
    public interface IRepository<T> where T : class
    {
        Task<IEnumerable<T>> GetAll();
        Task<T> GetById(int id);
        Task<T> Add(T entity);
        Task Update(T entity);
        Task Delete(T id);
        Task<T> GetByNotSoftDeletedId(int id);
        Task<IEnumerable<T>> GetAllNotSoftDeleted();
    }
}

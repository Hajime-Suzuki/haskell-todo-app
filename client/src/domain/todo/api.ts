import axios, { AxiosInstance } from 'axios'

const baseUrl = (process.env.NODE_ENV === 'production' && process.env.REACT_APP_API) || 'http://localhost:4000'

type SaveTodoArgs = {
  title: string
}

class TodoApi {
  private api: AxiosInstance
  constructor(private baseURL: string) {
    this.api = axios.create({ baseURL })
  }

  getTodos = async () => {
    const { data } = await this.api.get('/todos')
    console.log(data)
    return data
  }

  saveTodo = async (data: SaveTodoArgs) => {
    console.log(data)
  }
}

export const todoApi = new TodoApi(baseUrl)

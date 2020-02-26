import axios, { AxiosInstance } from 'axios'
import { Todo } from '../../domain/todo/todo'

const baseUrl = (process.env.NODE_ENV === 'production' && process.env.REACT_APP_API) || 'http://localhost:4000'

type SaveTodoArgs = {
  todo: Todo
}

class TodoApi {
  private api: AxiosInstance
  constructor(private baseURL: string) {
    this.api = axios.create({ baseURL })
  }

  getTodos = async () => {
    const { data } = await this.api.get<{ todos: Todo[] }>('/todos')
    return data
  }

  saveTodo = async (data: SaveTodoArgs) => {
    await this.api.post('/todos', data.todo)
  }

  deleteTodo = async (id: string)=> {
    await this.api.delete(`/todos/${id}`)
  }

  toggleDone = async (id: string, done: boolean) =>{
    await this.api.put(`/todos/${id}`, {done})
  }
}

export const todoApi = new TodoApi(baseUrl)

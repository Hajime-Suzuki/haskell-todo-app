import shortId from 'shortid'

export type Todo = {
  id: string
  title: string
  createdAt: string
  done: boolean
}

export const createTodo = (input: { title: string }): Todo => {
  return {
    id: shortId(),
    title: input.title,
    createdAt: new Date().toString(),
    done: false,
  }
}

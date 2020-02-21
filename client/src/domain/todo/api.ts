type SaveTodoArgs = {
  title: string
}
const saveTodo = (data: SaveTodoArgs) => {
  console.log(data)
}

export const todoApi = {
  saveTodo,
}

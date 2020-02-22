import React, { FC } from 'react'
import { Todo } from '../../../domain/todo/todo'
import { Maybe } from '../../../utils/types/types'
import { Table } from 'antd'
import { ColumnProps } from 'antd/lib/table'

type Props = {
  todos: Maybe<Todo[]>
}

const columns: ColumnProps<Todo>[] = [
  {
    title: 'Name',
    dataIndex: 'title',
  },
  {
    title: 'Done',
    dataIndex: 'done',
    render: val => {
      return val === true ? 'true' : 'false'
    },
  },
]

export const TodoList: FC<Props> = ({ todos }) => {
  return (
    <div>
      <Table dataSource={todos || undefined} columns={columns} pagination={false} rowKey={({ id }) => id} />
    </div>
  )
}

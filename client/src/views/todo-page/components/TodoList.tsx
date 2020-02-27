import { Button, Table as _Table } from 'antd'
import { ColumnProps, TableProps } from 'antd/lib/table'
import React, { FC } from 'react'
import styled from 'styled-components'
import { Todo } from '../../../domain/todo/todo'
import { withMotionDiv } from '../../../utils/animation/with-motion-div'
import { Maybe } from '../../../utils/types/types'
import { animationConfig } from '../animation-config'

type Props = {
  todos: Maybe<Todo[]>
  deleteTodo: (todoIndex: number) => Promise<void>
  toggleDone: (todo: Todo, selected: boolean) => Promise<void>
  toggleDoneAll: (selected: boolean) => Promise<void>
  deleteCompleted: () => Promise<void>
}

const TodoTable: FC<Props> = ({ todos, deleteTodo, toggleDone, toggleDoneAll, deleteCompleted }) => {
  const onSelect = (record: Todo, selected: boolean, _selectedRows: Object[], _e: Event) => {
    toggleDone(record, selected)
  }

  const selectedRowKeys = todos?.filter(({ done }) => done).map(({ id }) => id)

  const columns: ColumnProps<Todo>[] = [
    {
      title: 'Name',
      dataIndex: 'title',
    },
    {
      title: '',
      dataIndex: 'id',
      render: (_, __, index) => {
        return <Button onClick={() => deleteTodo(index)}>Delete</Button>
      },
    },
  ]

  return (
    <>
      <div style={{ textAlign: 'left', marginBottom: '1em' }}>
        <Button type="danger" onClick={deleteCompleted}>
          Delete completed
        </Button>
      </div>
      <Table
        dataSource={todos || undefined}
        columns={columns}
        rowClassName={record => (record.done ? 'isDone' : '')}
        pagination={false}
        rowKey={({ id }) => id}
        rowSelection={{
          onSelect,
          selectedRowKeys,
          onSelectAll: toggleDoneAll,
        }}
      />
    </>
  )
}

const Table = styled((props: TableProps<Todo>) => <_Table {...props} />)`
  & {
    .isDone {
      text-decoration: line-through;
      color: lightgray;
    }
  }
`

export const TodoList: FC<Props> = withMotionDiv(animationConfig, TodoTable)

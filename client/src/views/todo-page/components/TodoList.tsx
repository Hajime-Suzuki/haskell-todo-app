import { Table, Button } from 'antd'
import { ColumnProps } from 'antd/lib/table'
import { Variants } from 'framer-motion'
import React, { FC, useState } from 'react'
import { Todo } from '../../../domain/todo/todo'
import { withMotionDiv } from '../../../utils/animation/with-motion-div'
import { Maybe } from '../../../utils/types/types'

type Props = {
  todos: Maybe<Todo[]>
  deleteTodo: (todoIndex: number) => Promise<void>
}

const TodoTable: FC<Props> = ({ todos, deleteTodo }) => {
  const [selectedRowKeys, setSelectedRowKeys] = useState<string[] | number[]>([])

  const onSelectRowKeys = (selectedRowKeys: string[] | number[], _selectedRows: Todo[]) => {
    setSelectedRowKeys(selectedRowKeys)
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
    {
      title: '',
      dataIndex: 'id',
      render: (_, __, index) => {
        return <Button onClick={() => deleteTodo(index)}>Delete</Button>
      },
    },
  ]

  return (
    <Table
      dataSource={todos || undefined}
      columns={columns}
      pagination={false}
      rowKey={({ id }) => id}
      rowSelection={{ selectedRowKeys, onChange: onSelectRowKeys }}
    />
  )
}

const animationVariants: Variants = {
  hidden: {
    opacity: 0,
  },
  visible: {
    opacity: 1,
    transition: {
      duration: 0.5,
      delay: 0.5,
    },
  },
}

const animationConfig = {
  variants: animationVariants,
  initial: 'hidden',
  animate: 'visible',
}

export const TodoList: FC<Props> = withMotionDiv(animationConfig, TodoTable)

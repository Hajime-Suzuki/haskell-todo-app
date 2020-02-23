import { Table } from 'antd'
import { ColumnProps } from 'antd/lib/table'
import { Variants } from 'framer-motion'
import React, { FC } from 'react'
import { Todo } from '../../../domain/todo/todo'
import { withMotionDiv } from '../../../utils/animation/with-motion-div'
import { Maybe } from '../../../utils/types/types'

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

const TodoTable: FC<Props> = ({ todos }) => {
  return <Table dataSource={todos || undefined} columns={columns} pagination={false} rowKey={({ id }) => id} />
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

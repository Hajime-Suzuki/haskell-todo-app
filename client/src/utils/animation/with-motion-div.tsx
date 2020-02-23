import React, { FC } from 'react'
import { motion, HTMLMotionProps } from 'framer-motion'

export const withMotionDiv = (config: HTMLMotionProps<any>, Component: FC<any>) => (props: any) => (
  <motion.div {...config}>
    <Component {...props} />
  </motion.div>
)

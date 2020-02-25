import { Variants } from "framer-motion"

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

export const animationConfig = {
  variants: animationVariants,
  initial: 'hidden',
  animate: 'visible',
}
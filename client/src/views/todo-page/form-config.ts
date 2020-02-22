import { FormikConfig } from 'formik'
import { object, string } from 'yup'
import { createTodo, Todo } from '../../domain/todo/todo'

export type AddTodoFormValues = { title: string }

export const formConfig = (config: {
  onSubmit: (payload: { todo: Todo }) => Promise<void>
  onComplete?: (todo: Todo) => void
}): FormikConfig<AddTodoFormValues> => ({
  initialValues: { title: '' },
  onSubmit: async (values, { resetForm }) => {
    const todo = createTodo(values)
    config.onSubmit({ todo })
    resetForm()
    config.onComplete?.(todo)
  },
  validateOnChange: false,
  validateOnBlur: true,
  validationSchema: object().shape({
    title: string()
      .required()
      .min(2, 'name must be equal to or longer than 2 characters')
      .max(20, 'name must be shorter than 20 characters'),
  }),
})

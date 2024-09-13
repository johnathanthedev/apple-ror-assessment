import * as Yup from 'yup';

export const validationSchema = Yup.object({
  city: Yup.string()
    .required('Required'),
  state: Yup.string()
    .required('Required')
});

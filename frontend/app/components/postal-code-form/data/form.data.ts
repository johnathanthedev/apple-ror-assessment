import * as Yup from 'yup';

export const validationSchema = Yup.object({
  postalCode: Yup.number()
    .required('Required'),
});

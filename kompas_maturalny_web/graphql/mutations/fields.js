import gql from "graphql-tag";

export const ADD_USER_FIELD = gql`
    mutation addUserField($fieldId: ID!){
        addUserField(input: {fieldId: $fieldId}) {
            userField {
                id
                fieldOfStudy {
                    id
                }
                user {
                    id
                }
            }
        }
    }
`;
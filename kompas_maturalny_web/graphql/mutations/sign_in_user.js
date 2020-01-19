import gql from "graphql-tag";

export const SIGN_IN_USER = gql`
    mutation signInUser($email: String!, $password: String!){
        signInUser(input: {
            email: $email,
            password: $password
        }
        ) {
            user {
                id
                email
                role
                authenticationToken
            }
        }
    }
`;
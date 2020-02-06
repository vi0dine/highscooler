import gql from "graphql-tag";

export const SIGN_UP_USER = gql`
    mutation signUpUser($username: String!, $email: String!, $password: String!){
        signUpUser(input: {
            username: $username,
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
import gql from 'graphql-tag';

export const USER_FIELDS_QUERY = gql`
    query UserState {
        UserState @client {
            userFields @client
        }
    }
`;
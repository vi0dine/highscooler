import gql from 'graphql-tag';

export const FIELDS_QUERY = gql`
    query fields {
        fields {
            id
            name
            description
        }
    }
`;
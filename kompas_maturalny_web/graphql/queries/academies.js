import gql from 'graphql-tag';

export const ACADEMIES_QUERY = gql`
    query academies {
        academies {
            id
            name
            description
            city
        }
    }
`;
import gql from 'graphql-tag';

export const ACADEMIES_QUERY = gql`
    query academies($first: Int, $after: String) {
        academies(first: $first, after: $after) {
            pageInfo {
                hasNextPage
                endCursor
            }
            totalCount
            edges {
                node {
                    id
                    name
                    city
                    fieldOfStudies {
                        id
                    }
                }
            }
        }
    }
`;
import gql from 'graphql-tag';

export const FIELDS_QUERY = gql`
    query fields($first: Int, $after: String) {
      fields(first: $first, after: $after) {
        pageInfo {
          hasNextPage
          endCursor
        }
        totalCount
        edges {
          node {
            id
            name
            description
            academies {
              id
            }
          }
        }
      }
    }
`;
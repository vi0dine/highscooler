describe('Signing in with valid data', function() {
    it('Visits the Kompas Maturalny login page', function() {
        cy.factory('user', {username: 'example', email: 'example@example.com', password: 'test1234'});
        cy.visit('/login');

        cy.get('input[name="email"]')
          .type('example@example.com')
          .should('have.value', 'example@example.com');

        cy.get('input[name="password"]')
          .type('test1234')
          .should('have.value', 'test1234');

        cy.get('button').click();

        cy.location('pathname').should('eq', '/');
        cy.getCookies()
            .should('have.length', 1)
            .then((cookies) => {
                expect(cookies[0]).to.have.property('name', 'token')
            })
    })
});

describe('Signing In with invalid email format', function() {
    it('Visits the Kompas Maturalny login page', function() {
        cy.visit('/login');

        cy.get('input[name="email"]')
            .type('exampleexample.com')
            .should('have.value', 'exampleexample.com');

        cy.get('div.ant-form-explain')
            .contains('Podaj prawidłowy adres email');

        cy.get('input[name="password"]')
            .type('test1234')
            .should('have.value', 'test1234');

        cy.get('button').click();

        cy.location('pathname').should('eq', '/login');
        cy.getCookies()
            .should('have.length', 0)
    })
});

describe('Signing In with empty email', function() {
    it('Visits the Kompas Maturalny login page', function() {
        cy.visit('/login');

        cy.get('input[name="email"]')
            .should('have.value', '');

        cy.get('input[name="password"]')
            .type('test1234')
            .should('have.value', 'test1234');

        cy.get('div.ant-form-explain')
            .contains('Email nie może być pusty');

        cy.get('button').click();

        cy.location('pathname').should('eq', '/login');
        cy.getCookies()
            .should('have.length', 0)
    })
});

describe('Signing In with too short password', function() {
    it('Visits the Kompas Maturalny login page', function() {
        cy.visit('/login');

        cy.get('input[name="email"]')
            .type('example@example.com')
            .should('have.value', 'example@example.com');

        cy.get('input[name="password"]')
            .type('test')
            .should('have.value', 'test');

        cy.get('div.ant-form-explain')
          .contains('Hasło musi mieć co najmniej 8 znaków');

        cy.get('button').click();

        cy.location('pathname').should('eq', '/login');
        cy.getCookies()
            .should('have.length', 0)
    })
});

describe('Signing In with empty password', function() {
    it('Visits the Kompas Maturalny login page', function() {
        cy.visit('/login');

        cy.get('input[name="email"]')
            .type('example@example.com')
            .should('have.value', 'example@example.com');

        cy.get('div.ant-form-explain')
            .contains('Hasło nie może być puste');

        cy.get('input[name="password"]')
            .should('have.value', '');

        cy.get('button').click();

        cy.location('pathname').should('eq', '/login');
        cy.getCookies()
            .should('have.length', 0)
    })
});
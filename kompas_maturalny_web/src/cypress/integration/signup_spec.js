describe('Signing up with valid data', function() {
    it('Visits the Kompas Maturalny login page', function() {
        cy.visit('/login');

        cy.get('a').click();

        cy.get('input[name="username"]')
            .type('example')
            .should('have.value', 'example');

        cy.get('input[name="email"]')
            .type('example@yahoo.com')
            .should('have.value', 'example@yahoo.com');

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

describe('Signing up with empty username', function() {
    it('Visits the Kompas Maturalny login page', function() {
        cy.visit('/login');

        cy.get('a').click();

        cy.get('input[name="username"]')
            .should('have.value', '');

        cy.get('input[name="email"]')
            .type('example@yahoo.com')
            .should('have.value', 'example@yahoo.com');

        cy.get('input[name="password"]')
            .type('test1234')
            .should('have.value', 'test1234');

        cy.get('div.ant-form-explain')
            .contains('Nazwa użytkownika nie może być pusta');

        cy.get('button').click();

        cy.location('pathname').should('eq', '/login');
        cy.getCookies()
            .should('have.length', 0)
    })
});

describe('Signing up with invalid email format', function() {
    it('Visits the Kompas Maturalny login page', function() {
        cy.visit('/login');

        cy.get('a').click();

        cy.get('input[name="username"]')
            .type('example')
            .should('have.value', 'example');

        cy.get('input[name="email"]')
            .type('exampleyahoo.com')
            .should('have.value', 'exampleyahoo.com');

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

describe('Signing up with empty email', function() {
    it('Visits the Kompas Maturalny login page', function() {
        cy.visit('/login');

        cy.get('a').click();

        cy.get('input[name="username"]')
            .type('example')
            .should('have.value', 'example');

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

describe('Signing up with too short password', function() {
    it('Visits the Kompas Maturalny login page', function() {
        cy.visit('/login');

        cy.get('a').click();

        cy.get('input[name="username"]')
            .type('example')
            .should('have.value', 'example');

        cy.get('input[name="email"]')
            .type('example@yahoo.com')
            .should('have.value', 'example@yahoo.com');

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

describe('Signing up with empty password', function() {
    it('Visits the Kompas Maturalny login page', function() {
        cy.visit('/login');

        cy.get('a').click();

        cy.get('input[name="username"]')
            .type('example')
            .should('have.value', 'example');

        cy.get('input[name="email"]')
            .type('example@yahoo.com')
            .should('have.value', 'example@yahoo.com');

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
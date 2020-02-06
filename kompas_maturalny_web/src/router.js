import React from "react";
import {BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import AcademiesPage from "./pages/AcademiesPage/Academies.page";
import FieldsPage from "./pages/FieldsPage/Fields.page";
import LoginPage from "./pages/LoginPage/Login.page";
import FieldPage from "./pages/FieldPage/Field.page";

const Routes = () => {
    return (
        <Router>
            <Switch>
                <Route exact path={'/'}>
                </Route>
                <Route exact path={'/fields'}>
                    <FieldsPage/>
                </Route>
                <Route path={'/fields/:id'}>
                    <FieldPage/>
                </Route>
                <Route path={'/academies'}>
                    <AcademiesPage/>
                </Route>
                <Route path={'/login'}>
                    <LoginPage/>
                </Route>
            </Switch>
        </Router>
    );
};

export default Routes;
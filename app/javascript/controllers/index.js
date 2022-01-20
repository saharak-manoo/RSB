/** @format */

// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from './application';

import HelloController from './hello_controller';
import BranchProductsController from './branch_products_controller';
application.register('home', HelloController);
application.register('branch-products', BranchProductsController);

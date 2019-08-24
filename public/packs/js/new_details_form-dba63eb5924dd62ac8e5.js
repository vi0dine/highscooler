/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./app/javascript/packs/new_details_form.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/javascript/packs/new_details_form.js":
/*!**************************************************!*\
  !*** ./app/javascript/packs/new_details_form.js ***!
  \**************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

throw new Error("Module build failed (from ./node_modules/babel-loader/lib/index.js):\nSyntaxError: /home/viodine/Projects/highschooler/app/javascript/packs/new_details_form.js: Identifier 'subject' has already been declared (20:12)\n\n  18 | \n  19 |       formatSubject(subject) {\n> 20 |         let subject = `(${subject}_Pp*${this.basic_ratio})|(${subject}_Pr*${this.advanced_ratio })`;\n     |             ^\n  21 |         formula += subject\n  22 |       }\n  23 |     }\n    at Parser.raise (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:6344:17)\n    at ScopeHandler.checkRedeclarationInScope (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:3757:12)\n    at ScopeHandler.declareName (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:3723:12)\n    at Parser.checkLVal (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:8034:22)\n    at Parser.parseVarId (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:10465:10)\n    at Parser.parseVar (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:10436:12)\n    at Parser.parseVarStatement (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:10258:10)\n    at Parser.parseStatementContent (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:9855:21)\n    at Parser.parseStatement (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:9788:17)\n    at Parser.parseBlockOrModuleBlockBody (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:10364:25)\n    at Parser.parseBlockBody (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:10351:10)\n    at Parser.parseBlock (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:10335:10)\n    at Parser.parseFunctionBody (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:9408:24)\n    at Parser.parseFunctionBodyAndFinish (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:9378:10)\n    at Parser.parseMethod (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:9332:10)\n    at Parser.parseObjectMethod (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:9248:19)\n    at Parser.parseObjPropValue (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:9290:23)\n    at Parser.parseObjectMember (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:9214:10)\n    at Parser.parseObj (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:9138:25)\n    at Parser.parseExprAtom (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:8774:21)\n    at Parser.parseExprSubscripts (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:8413:23)\n    at Parser.parseMaybeUnary (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:8393:21)\n    at Parser.parseExprOps (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:8280:23)\n    at Parser.parseMaybeConditional (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:8253:23)\n    at Parser.parseMaybeAssign (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:8200:21)\n    at Parser.parseObjectProperty (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:9265:101)\n    at Parser.parseObjPropValue (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:9290:101)\n    at Parser.parseObjectMember (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:9214:10)\n    at Parser.parseObj (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:9138:25)\n    at Parser.parseExprAtom (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:8774:21)\n    at Parser.parseExprSubscripts (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:8413:23)\n    at Parser.parseMaybeUnary (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:8393:21)\n    at Parser.parseExprOps (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:8280:23)\n    at Parser.parseMaybeConditional (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:8253:23)\n    at Parser.parseMaybeAssign (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:8200:21)\n    at Parser.parseExprListItem (/home/viodine/Projects/highschooler/node_modules/@babel/parser/lib/index.js:9475:18)");

/***/ })

/******/ });
//# sourceMappingURL=new_details_form-dba63eb5924dd62ac8e5.js.map
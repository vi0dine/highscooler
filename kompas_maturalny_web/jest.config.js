module.exports = {
    moduleFileExtensions: ["js", "jsx", "ts", "tsx"],
    testMatch: ["**/*.(test|spec).(js|jsx)"],
    coveragePathIgnorePatterns: ["/node_modules/"],
    setupFilesAfterEnv: ["<rootDir>/tests/jest.setup.js"],
    coverageReporters: ["json", "lcov", "text", "text-summary"],
    moduleNameMapper: {
        "\\.(jpg|jpeg|png|gif|eot|otf|webp|svg|ttf|woff|woff2|mp4|webm|wav|mp3|m4a|aac|oga)$":
            "<rootDir>/tests/mocks.js",
        "\\.(css|less|scss|html)$": "<rootDir>/tests/mocks.js",
        "^@(Test)(.*)$": "<rootDir>/tests/$2",
        "^@([A-Z].*)$": "<rootDir>/src/$1",
    }
};
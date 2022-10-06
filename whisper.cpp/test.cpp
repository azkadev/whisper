#include <iostream>
#include "json/json.hpp"

using json = nlohmann::json;

extern "C" void print(std::string value)
{
    std::cout << value << std::endl;
}

extern "C" char *jsonToChar(json jsonData)
{
    std::string result = jsonData.dump();
    char *ch = new char[result.size() + 1];
    strcpy(ch, result.c_str());
    return ch;
}

extern "C" char *request(char *body)
{
    json jsonBody = json::parse(body); 
    json jsonResult;
    if (jsonBody["@type"] == "azka")
    {
        print("benar");
    }
    else
    {
        print("benar");
    }
    jsonResult["@type"] = "error";
    jsonResult["message"] = "method not found";
    return jsonToChar(jsonResult);
}

int main()
{
    char azka = 'a';
    // std::string text;

    // // convertion from char string to c++ string
    // // using assign function
    // text.assign(azka);

    // std::cout << text << std::endl;
    // create an empty structure (null)
    json jsonData = azka;
    json j;

    // add a number that is stored as double (note the implicit conversion of j to an object)
    j["@type"] = "transcribe";

    // add a Boolean that is stored as bool
    j["happy"] = true;

    // add a string that is stored as std::string
    j["name"] = "Niels";

    // add another null object by passing nullptr
    j["nothing"] = nullptr;

    // add an object inside the object
    j["answer"]["everything"]["asasa"]["sasasa"] = 42;

    // add an array that is stored as std::vector (using an initializer list)
    j["list"] = {1, 0, 2};
    // add a number that is stored as double (note the implicit conversion of j to an object)
    j["@type"] = "error";
    // add another object (using an initializer list of pairs)
    j["object"] = {{"currency", "USD"}, {"value", 42.99}};
    std::cout << j.dump() << std::endl;
    return 0;
}

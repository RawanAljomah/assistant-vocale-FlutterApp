import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
//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   
//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
const OpenAi = '';
class OpenAI {
 static void DallAPI(){

 }
 static void ChatGptAPI(){

 }
 static void getPromptResponse(String prompt)async{
   final res = await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
    headers:
          {
            "Content-Type" : "application/json",
            "Authorization": "Bearer $OpenAi",
          },
    body:
        jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content": "does this prompt generate image ? $prompt  please answer with yes or no !"
            }
          ]
        })
        ,
   );
   print("response is :"+res.body);
   if(res.statusCode==200){
      final answers= jsonDecode(res.body)["choice"][0]["message"]["content"];
      if(answers == 'yes'){
        DallAPI();
      }else{
        ChatGptAPI();
      }
   }
   
  }
}


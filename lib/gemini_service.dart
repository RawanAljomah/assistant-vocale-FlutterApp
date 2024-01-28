import 'package:googleai_dart/googleai_dart.dart';

Future<String> getGeminiResponse(String prompt) async {
  final client = GoogleAIClient(apiKey: 'AIzaSyB8VfguzbRRhWFPrNZKCwiZE2iOOVmNbV4');
  final res = await client.generateContent(
    modelId: 'gemini-pro',
    request: GenerateContentRequest(
      contents: [
        Content(parts: [
          Part(text: prompt),
        ]),
      ],
      generationConfig: GenerationConfig(temperature: 0.8),
    ),
  );
  print(res.candidates?.first.content?.parts?.first.text);

  return res.candidates?.first.content?.parts?.first.text ?? 'No output';
}
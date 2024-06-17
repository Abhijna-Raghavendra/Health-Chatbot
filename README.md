# Health-Chatbot

Imagine facing a health issue and feeling overwhelmed by the high costs of consulting doctors or the anxiety of searching symptoms online, where results often lead to unnecessary panic. Many people encounter these challenges daily, unsure where to turn for reliable medical guidance without breaking the bank or risking misinformation.

To address this, our project introduces a solution: a free, sensible healthcare chatbot. This bot is designed to provide accurate medical advice in a clear and reassuring manner, offering a reliable alternative to expensive consultations and unreliable online searches. It aims to empower users with the information they need to make informed health decisions confidently and affordably.

### Setup

*To setup the project locally, follow these steps:*

  - Clone the Repository and ```cd``` into it
    ```sh
    git clone https://github.com/Abhijna-Raghavendra/Health-Chatbot.git
    cd Health-Chatbot
    ```
1. #### Server
   - Use docker to build the image and run the backend application
    ```sh
    cd server/
    docker compose up --build -d
    ```
    > If you do not already have docker installed  on your system, visit [here](https://www.docker.com/products/docker-desktop/)

2. #### Mobile Application
    - Get the required dependencies, Compile and build the apk after making necessary changes to the backend url found at ```mobile/lib/utils.dart```
    ```sh
    flutter pub get
    flutter build apk #for android
    flutter build ios #for ios
    ```
### Features

1. **Authentication and Secure Storage of User-Specific Information**: Ensures user data privacy through secure storage mechanisms, while allowing the user to login to his profile through multiple devices.

2. **Chatbot Enhanced with Retrieval-Augmented Generation (RAG) for Medical Context**: Employs the RAG architecture to provide accurate, contextually relevant responses by integrating medical knowledge retrieval into conversational interactions.

3. **Initiation of Emergency Contact Calls**: Enables users to swiftly contact predefined emergency contacts directly through the chatbot interface, ensuring prompt assistance during critical situations.

4. **Speech-to-text Conversion**: Converts spoken language into text format, facilitating seamless interaction with the chatbot for users who prefer speaking over typing.

### Contributors

| Contributor | GitHub | Description |
|-------------|------------------|-------------|
| Abhijna Raghavendra | <div align="center"><img src="https://github.com/Abhijna-Raghavendra.png" width="100" height="100" style="border-radius: 50%;"><br>[Abhijna-Raghavendra](https://github.com/Abhijna-Raghavendra)</div> | //add cool description here |
| Angel Sharma | <div align="center"><img src="https://github.com/fillingtothemomo.png" width="100" height="100" style="border-radius: 50%;"><br>[fillingtothemomo](https://github.com/fillingtothemomo)</div> | //add cool description here |



part of 'pages.dart';

class AnonSignInPage extends StatelessWidget {
  const AnonSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* TITLE
            const Text(
              'SIGN IN ANONYMOUSLY',
            ),
            const SizedBox(height: 10),

            //* SIGN IN STATUS
            // CODE HERE: Change status based on current user
            StreamBuilder<Object>(
              stream: null,
              builder: (context, snapshot) {
                return const Text("You haven't signed in yet");
              }
            ),
            const SizedBox(height: 15),

            //* SIGN IN BUTTON
            SizedBox(
              width: 150,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue.shade900)),
                  onPressed: () {
                    // CODE HERE: Sign in anonymously / Sign out from firebase
                  },
                  // CODE HERE: Change button text based on current user
                  child: const Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

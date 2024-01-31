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
            StreamBuilder<User?>(
                stream: FirebaseAuth.instance.userChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text("Signed in as ${snapshot.data?.uid}");
                  } else {
                    return const Text("You haven't signed in yet");
                  }
                }),
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
                    if (FirebaseAuth.instance.currentUser != null) {
                      FirebaseAuth.instance.signOut();
                    } else {
                      FirebaseAuth.instance.signInAnonymously();
                    }
                  },
                  // CODE HERE: Change button text based on current user
                  child: StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.userChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return const Text(
                            "Sign Out",
                            style: TextStyle(color: Colors.white),
                          );
                        } else {
                          return const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white),
                          );
                        }
                      })),
            )
          ],
        ),
      ),
    );
  }
}

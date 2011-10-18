/*
 * This class implements a mocked auth Client to test authentication services
 * in Juno.
 *
 * (c) 2011 Sourdough Labs Research and Development Corp.
 *
 */
import java.util.Map;
import java.util.HashMap;

/**
 *
 * @author Vince Hodges
 */
public final class MockAuthClient
{
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        System.out.println("Starting...........");

        MockAuthClient client = new MockAuthClient(null);

        Map results;

        // Test success
        System.out.println("Expecting Joe Working");
        results = client.authenticateMember("98765", "1", "12345");
        System.out.println("Got " + ((Map)results.get("user_info")).get("name"));

        // Test failure
        System.out.println("Expecting invalid_credidentials");
        results = client.authenticateMember("98765", "1", "54321");
        System.out.println("Got " + results.get("error"));

        // Test disclaimer needed
        System.out.println("Expecting disclaimer_needed");
        results = client.authenticateMember("disclaimer", "1", "54321");
        System.out.println("Got " + results.get("error"));

        // Test failure
        System.out.println("Expecting pac_change_needed");
        results = client.authenticateMember("change_pac", "1", "54321");
        System.out.println("Got " + results.get("error"));

        System.out.println("Done");
    }

    public MockAuthClient(Map opts) {
        // Not used, but the signature must match
    }

    public synchronized Map authenticateMember(String account, String branch, String pac) {

        HashMap auth_info = new HashMap();

        if (account.equals("98765") && branch.equals("1") && pac.equals("12345") )  {

            HashMap user_info = new HashMap();

            user_info.put("branch", branch);
            user_info.put("account", account);
            user_info.put("name", "Joe Working");

            auth_info.put("user_info", user_info);
        } else {
            auth_info.put("error", "invalid_credentials");

            if (account.equals("disclaimer")) {
                    auth_info.put("error", "disclaimer_needed");
                }

            if (account.equals("change_pac")) {
                auth_info.put("error", "pac_change_needed");
            }
        }

        return auth_info;
    }
}

import React from "react";
import { Image, StyleSheet, Text, View } from "react-native";

const IAmRichApp = () => {
  return (
    <View style={styles.container}>
      <Text style={styles.text}>I Am Rich</Text>
      <Image
        source={require("../../assets/images/money.png")}
        style={styles.image}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#d5db34ff",
    justifyContent: "center",
    alignItems: "center",
  },
  text: {
    fontSize: 40,
    fontWeight: "bold",
    color: "#994419ff",
    marginBottom: 20,
  },
  image: {
    width: 420,
    height: 420,
    resizeMode: "contain",
  },
});

export default IAmRichApp;

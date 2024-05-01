matchWeightF({int weight1 = 10, int weight2 = 10}) {
  if (weight1 == weight2 ||
      weight1 + 1 == weight2 ||
      weight1 + 2 == weight2 ||
      weight1 + 3 == weight2 ||
      weight1 + 4 == weight2 ||
      weight1 + 5 == weight2 ||
      weight1 + 6 == weight2 ||
      weight1 + 7 == weight2 ||
      weight1 + 8 == weight2 ||
      weight1 + 9 == weight2 ||
      weight1 + 10 == weight2 ||
      weight1 - 1 == weight2 ||
      weight1 - 2 == weight2 ||
      weight1 - 3 == weight2 ||
      weight1 - 4 == weight2 ||
      weight1 - 5 == weight2 ||
      weight1 - 6 == weight2 ||
      weight1 - 7 == weight2 ||
      weight1 - 8 == weight2 ||
      weight1 - 9 == weight2 ||
      weight1 - 10 == weight2) {
    return true;
  } else {
    return false;
  }
}

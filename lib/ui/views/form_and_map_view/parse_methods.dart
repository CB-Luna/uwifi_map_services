String parseLocation(String location) {
  String parsedText = '';
  switch (location) {
    case 'cry':
      parsedText = "Crystal Beach";
      break;

    case 'ode':
      parsedText = "Midland - Odessa";
      break;

    case 'smi':
      parsedText = "Smithville";
      break;

    case 'cry_hf':
      parsedText = "Hamshire-Fannett";
      break;

    case 'cry_sh':
      parsedText = "S. Houston";
      break;

    case 'cry_bch':
      parsedText = "Crystal Beach";
      break;
  }
  return parsedText;
}

String parseServiceType(String serviceType) {
  String parsedServiceType = '';
  if (serviceType != 'Fiber') {
    parsedServiceType = 'Fixed Wireless';
  } else {
    parsedServiceType = serviceType;
  }
  return parsedServiceType;
}

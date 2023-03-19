from androguard.core.analysis.analysis import Analysis, ExternalMethod
from androguard.core.bytecodes.apk import APK
from androguard.core.bytecodes.dvm import DalvikVMFormat, EncodedMethod, Instruction
from androguard.misc import AnalyzeAPK
import time
import logging

from networkx import DiGraph


def is_android_api(n):
    """

    :type n: ExternalMethod or EncodedMethod
    """
    if not isinstance(n, ExternalMethod):
        return False

    classname = n.get_class_name()

    # Packages found at https://developer.android.com/reference/packages.html
    api_candidates = ["Landroid/", "Lcom/android/internal/util", "Ldalvik/", "Ljava/", "Ljavax/", "Lorg/apache/",
                      "Lorg/json/", "Lorg/w3c/dom/", "Lorg/xml/sax", "Lorg/xmlpull/v1/", "Ljunit/"]

    for candidate in api_candidates:
        if classname.startswith(candidate):
            return True

    return False


def list_api_calls(file_path):

    start_time = time.time()
    logging.warning('{}'.format(file_path))
    try:
        a, d, dx = AnalyzeAPK(file_path)  # type: (APK, list[DalvikVMFormat], Analysis)

        cg = dx.get_call_graph()    # type: DiGraph

        apis = filter(lambda x: is_android_api(x), cg.nodes)    # type: list[ExternalMethod]

    except Exception:
        apis = []
        logging.error(file_path)

    end_time = time.time()
    logging.warning('{} cost {:.2f}s'.format(file_path, end_time - start_time))
    return apis


def list_internal_methods(file_path):

    start_time = time.time()
    logging.warning('{} is processing...'.format(file_path))

    a, d, dx = AnalyzeAPK(file_path)  # type: (APK, list[DalvikVMFormat], Analysis)

    cg = dx.get_call_graph()    # type: DiGraph

    internal_methods = filter(lambda x: isinstance(x, EncodedMethod), cg.nodes)    # type: list[EncodedMethod]

    end_time = time.time()
    logging.warning('{} cost {}s'.format(file_path, format(end_time - start_time, '.2f')))

    return internal_methods


def extract_dex(file_path):

    start_time = time.time()
    logging.warning('{} is processing...'.format(file_path))

    a, d, dx = AnalyzeAPK(file_path)  # type: (APK, list[DalvikVMFormat], Analysis)

    dex = list(a.get_all_dex())[0]

    end_time = time.time()
    logging.warning('{} cost {}s'.format(file_path, format(end_time - start_time, '.2f')))

    return dex


def get_opcode_seq(file_path):
    start_time = time.time()
    logging.warning('{} is processing...'.format(file_path))

    a, d, dx = AnalyzeAPK(file_path)  # type: (APK, list[DalvikVMFormat], Analysis)

    cg = dx.get_call_graph()

    internal_methods = filter(lambda x: isinstance(x, EncodedMethod), cg.nodes)
    opcode_seq = []
    for n in internal_methods:
        method_seq = []
        for i in n.get_instructions():  # type: Instruction
            method_seq.append(i.get_name())
        opcode_seq.append(method_seq)

    end_time = time.time()
    logging.warning('{} cost {}s'.format(file_path, format(end_time - start_time, '.2f')))

    return opcode_seq

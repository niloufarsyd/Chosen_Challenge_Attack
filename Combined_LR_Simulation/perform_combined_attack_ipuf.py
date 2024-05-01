from puf_simulation_framework.attack_framework import ReliabilityAttackManager
from puf_simulation_framework.attack_framework import PathManager
from puf_simulation_framework.pufs import PUFWrapper, XorArbiterPuf, InterposePuf
from puf_simulation_framework.pytorch_gradient_attack import MultiXorArbiterNet, PytorchMultiXorReliability, \
    CombinedAttackXor, CombinedAttackIPUF, MultiInterposePufNet
import numpy as np
import torch
import time

start = time.time()
torch.set_num_threads(1)

num_xors = 2
# torch.autograd.set_detect_anomaly(True)
puf_parameter = {'num_stages': 64,
                 'num_x_xor_pufs': 4,
                 'num_y_xor_pufs': 4,
                 'create_feature_vectors': True,
                 'y_pivot': 32,
                 'enable_noise': True,
                 'noise_type': 'gauss',
                 'gauss_error_var': 0}
puf_wrapper = PUFWrapper(puf_class=InterposePuf, puf_parameters=puf_parameter)

model_parameters = {'num_stages': puf_parameter['num_stages'],
                    'num_x_xors': puf_parameter['num_x_xor_pufs'],
                    'num_y_xors': puf_parameter['num_y_xor_pufs'],
                    'y_pivot': puf_parameter['y_pivot'],
                    'num_multi_pufs': 6,
                    'y_output_type': 'sigmoid_and_abs_raw',
                    'input_is_feature_vector': True}

optim_parameters = {'optimizer_name': 'Adadelta', 'optimizer_parameters': {}}
fit_parameters = {'batch_size': 256,
                  'num_epochs': 25,
                  'verbose': True,
                  'num_trials': 8,
                  'enable_reliability_loss': True,
                  'constraint_arbiter_weights_within_multipuf': True,
                  'constraint_loss_multiplier': 0.2,
                  'x_reliability_loss_multiplier': 0.5,
                  'y_reliability_loss_multiplier': 1,
                  'prediction_loss_multiplier': 30,#30
                  'enable_prediction_loss': True,
                  'print_loss':False,
                  'y_pivot': puf_parameter['y_pivot']
                  }
attack_parameters = {'num_pufs_to_attack': 1,
                     'training_set_size': 500000,
                     'test_set_size': 2000,
                     'validation_set_size': 2000,
                     'add_validation': True,
                     'add_puf_to_fit': True,
                     'perform_reliability_attack': True,
                     'perform_NFPr_attack':True,# 'perform_NFPr_attack':True for the non-flipping-probability based combined attach and 'perform_NFPr_attack':False for the reliability based combined attack
                     'nSamples':16,
                     'num_flips_for_NFPr':1,
                     'reliability_repetitions': 17,# because nSamples is 16, to have a fair comparison the reliability_repetitions should be 16+1
                     'reliability_type': 'minus_abs',
                     }

# pytorch_attack_wrapper = PytorchIPUFReliabilityWithXorModel(XorArbiterNet, model_parameters, optim_parameters,
#                                                           fit_parameters)
pytorch_attack_wrapper = CombinedAttackIPUF(MultiInterposePufNet, model_parameters, optim_parameters, fit_parameters)

path_manager = PathManager()
path_manager.update_path_content(dict(base_path_name='./puf_experiment_results',
                                      topic_name='reliability_test_runs'))
attack_manager = ReliabilityAttackManager(path_manager)
attack_manager.attack_puf_population(puf_wrapper, attack_parameters, pytorch_attack_wrapper)

duration = time.time() - start
print('Duration {:.2f}'.format(duration))
print()

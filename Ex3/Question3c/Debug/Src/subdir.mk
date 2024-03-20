################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Src/3c_Transmit.s \
../Src/3c_assembly.s \
../Src/3c_definitions.s \
../Src/3c_info.s 

OBJS += \
./Src/3c_Transmit.o \
./Src/3c_assembly.o \
./Src/3c_definitions.o \
./Src/3c_info.o 

S_DEPS += \
./Src/3c_Transmit.d \
./Src/3c_assembly.d \
./Src/3c_definitions.d \
./Src/3c_info.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.s Src/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Src

clean-Src:
	-$(RM) ./Src/3c_Transmit.d ./Src/3c_Transmit.o ./Src/3c_assembly.d ./Src/3c_assembly.o ./Src/3c_definitions.d ./Src/3c_definitions.o ./Src/3c_info.d ./Src/3c_info.o

.PHONY: clean-Src


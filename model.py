import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler

df = pd.read_csv('budget_data.csv')

df['Overspent (Label)'] = df['Overspent (Label)'].astype(int)

X = df[['Total Budget', 'Spend Amount', 'Left Amount']]
y = df['Overspent (Label)']

scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

X_train, X_valid, y_train, y_valid = train_test_split(X_scaled, y, test_size=0.2, random_state=42)

model = Sequential([
    Dense(64, activation='relu', input_shape=[X_train.shape[1]]),
    Dense(32, activation='relu'),
    Dense(1, activation='sigmoid')
])

model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])

model.fit(X_train, y_train, epochs=10, validation_split=0.2)

loss, accuracy = model.evaluate(X_valid, y_valid)
print(f"Validation accuracy: {accuracy:.4f}")

model.save('model.h5')